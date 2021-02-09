//
//  CategoryTableViewCell.swift
//  Demo
//
//  Created by Vivek Purohit on 09/02/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableviewSubCat: UITableView!
    
    var catId: Int! = 0
    var arrSubCat: [ProductSubCat]! {
        didSet {
            datasource = arrSubCat
        }
    }
    var sprView: UIViewController!
    
    var datasource: [ProductSubCat]! {
        didSet {
            if tableviewSubCat != nil {
                tableviewSubCat.reloadData()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        tableviewSubCat.delegate = self
        tableviewSubCat.dataSource = self
        tableviewSubCat.register(UINib(nibName: "SubCatTableViewCell", bundle: nil), forCellReuseIdentifier: "SubCatTableViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
//MARK:- IBActions
extension CategoryTableViewCell {
    @IBAction func addProductTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Product", message: "Add a new Sub-Category", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first, let categoryName = textField.text else {
                return
            }
            CoreDataHelper.shared.saveSubCategory(name: categoryName, for: catId)
            self.arrSubCat = ProductListViewModel.shared.getSubCat(forCatId: catId)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.sprView.present(alert, animated: true)
    }
}
//MARK:- UISearchBarDelegate
extension CategoryTableViewCell: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            datasource = arrSubCat
        }
        else {
            datasource = arrSubCat.filter { (product) -> Bool in
                return product.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        datasource = arrSubCat
        self.searchBar.resignFirstResponder()
    }
}
// MARK: - UITableViewDataSource and UITableViewDelegate
extension CategoryTableViewCell: UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
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
        labelProduct.text = datasource[section].name
        
        checkMark.frame = CGRect(x: viewHeader.bounds.width - 16 - 24, y: 13.5, width: 24, height: 24)
        checkMark.isHidden = !datasource[section].isSelected
        
        return viewHeader
    }
    
    @objc func expandButtonTapEvent(_ sender: UIButton) {
        let section = sender.tag
        datasource[section].isSelected.toggle()
        tableviewSubCat.reloadData()
    }
    
    //MARK:- Cells
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].isSelected ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCatTableViewCell", for: indexPath) as! SubCatTableViewCell
        cell.subCatId = datasource[indexPath.section].id
        cell.sprView = sprView
        cell.arrProducts = datasource[indexPath.section].products
        cell.datasource = datasource[indexPath.section].products
        cell.searchBar.text = ""
        cell.tableviewProd.reloadData()
        return cell
    }
}
