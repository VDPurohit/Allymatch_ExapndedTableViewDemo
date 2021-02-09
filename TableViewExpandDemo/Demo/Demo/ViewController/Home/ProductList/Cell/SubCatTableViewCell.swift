//
//  SubCatTableViewCell.swift
//  Demo
//
//  Created by Vivek Purohit on 09/02/21.
//

import UIKit

class SubCatTableViewCell: UITableViewCell {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableviewProd: UITableView!
    
    var subCatId: Int! = 0
    var arrProducts: [ProductObj]! {
        didSet {
            datasource = arrProducts
        }
    }
    var sprView: UIViewController!
    
    var datasource: [ProductObj]! {
        didSet {
            if tableviewProd != nil {
                tableviewProd.reloadData()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        tableviewProd.delegate = self
        tableviewProd.dataSource = self
        tableviewProd.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
//MARK:- IBActions
extension SubCatTableViewCell {
    @IBAction func addProductTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "New Product", message: "Add a new Sub-Product", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first, let categoryName = textField.text else {
                return
            }
            CoreDataHelper.shared.saveProduct(name: categoryName, for: subCatId)
            self.arrProducts = ProductListViewModel.shared.getProducts(forSubCatId: subCatId)
            self.datasource = self.arrProducts
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.sprView.present(alert, animated: true)
    }
}
//MARK:- UISearchBarDelegate
extension SubCatTableViewCell: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            datasource = arrProducts
        }
        else {
            datasource = arrProducts.filter { (product) -> Bool in
                return product.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        datasource = arrProducts
        self.searchBar.resignFirstResponder()
    }
}
// MARK: - UITableViewDataSource and UITableViewDelegate
extension SubCatTableViewCell: UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- Sections
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return arrProducts.count
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
//        viewHeader.backgroundColor = .white
//        let labelProduct = UILabel(frame: CGRect(x: 16, y: 0, width: viewHeader.bounds.width - 16, height: viewHeader.bounds.height))
//        let buttonExpand = UIButton(frame: viewHeader.bounds)
//        viewHeader.addSubview(labelProduct)
//        viewHeader.addSubview(buttonExpand)
//        buttonExpand.tag = section
//        buttonExpand.addTarget(self, action: #selector(expandButtonTapEvent(_:)), for: .touchUpInside)
//        labelProduct.text = arrProducts[section].name
//        return viewHeader
//    }
//
//    @objc func expandButtonTapEvent(_ sender: UIButton) {
//        let section = sender.tag
//        arrProducts[section].isSelected.toggle()
//        tableviewSubCat.reloadData()
//    }
    
    //MARK:- Cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        cell.labelProductName.text = datasource[indexPath.row].name
        cell.checkMark.isHidden = !datasource[indexPath.row].isSelected
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        datasource[indexPath.row].isSelected.toggle()
        tableviewProd.reloadData()
    }
}
