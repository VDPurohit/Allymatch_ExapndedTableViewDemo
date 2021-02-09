//
//  ProductListVC.swift
//  Demo
//
//  Created by Vivek Purohit on 09/02/21.
//

import UIKit

class ProductListVC: BaseVC {
    
    @IBOutlet var tableviewProducts: UITableView!
    
    private var arrProducts = [ProductCat]() {
        didSet {
            if tableviewProducts != nil {
                tableviewProducts.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        arrProducts = ProductListViewModel.shared.getDatasource()
        tableviewProducts.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
}
//MARK:- IBActions
extension ProductListVC {
    @IBAction func addProductTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Product", message: "Add a new Category", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first, let categoryName = textField.text else {
                return
            }
            CoreDataHelper.shared.saveCategory(name: categoryName)
            self.arrProducts = ProductListViewModel.shared.getDatasource()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
}
// MARK: - UITableViewDataSource and UITableViewDelegate
extension ProductListVC: UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrProducts.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
        viewHeader.backgroundColor = .white
        let labelProduct = UILabel(frame: CGRect(x: 16, y: 0, width: viewHeader.bounds.width - 16, height: viewHeader.bounds.height))
        let buttonExpand = UIButton(frame: viewHeader.bounds)
        let checkMark = UIImageView(image: UIImage(named: "tick"))
        viewHeader.addSubview(labelProduct)
        viewHeader.addSubview(buttonExpand)
        viewHeader.addSubview(checkMark)
        buttonExpand.tag = section
        buttonExpand.addTarget(self, action: #selector(expandButtonTapEvent(_:)), for: .touchUpInside)
        labelProduct.text = arrProducts[section].name
        
        checkMark.frame = CGRect(x: viewHeader.bounds.width - 16 - 24, y: 13.5, width: 24, height: 24)
        checkMark.isHidden = !arrProducts[section].isSelected
        
        return viewHeader
    }
    
    @objc func expandButtonTapEvent(_ sender: UIButton) {
        let section = sender.tag
        arrProducts[section].isSelected.toggle()
        tableviewProducts.reloadData()
    }
    
    //MARK:- Cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProducts[section].isSelected ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.catId = arrProducts[indexPath.section].id
        cell.sprView = self
        cell.arrSubCat = arrProducts[indexPath.section].subCat
        cell.datasource = arrProducts[indexPath.section].subCat
        cell.searchBar.text = ""
        cell.tableviewSubCat.reloadData()
        return cell
    }
}
