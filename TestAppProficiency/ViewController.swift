//
//  ViewController.swift
//  TestAppProficiency
//
//  Created by user167484 on 3/17/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//c

import UIKit

class ViewController: UIViewController {

    var tableview: UITableView = UITableView()
    var tableData: [Model] = []
    private var imageCache = NSCache<NSString, UIImage>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        setup()
        

        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(ImageLoadTableViewCell.self, forCellReuseIdentifier: "imageDetailCell")
        fetchData()
    }
    
    func fetchData() {
        imageCache.removeAllObjects()
        Request.fetchData.execute(success: { [weak self] (response, data: DataModel) in
            self?.navigationItem.title = data.title ?? ""
            self?.tableData = data.data ?? []
            self?.tableview.reloadData()
        }, failure: { (error) in
            print(error)
        })
    }
    
    func setup() {
        let a = NSLayoutConstraint(item: tableview, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 0)
        let b = NSLayoutConstraint(item: tableview, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: 0)
        let c = NSLayoutConstraint(item: tableview, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 0)
        let d = NSLayoutConstraint(item: tableview, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([a,b,c,d])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageDetailCell") as! ImageLoadTableViewCell
        if let image = imageCache.object(forKey: NSString(string: "\(indexPath.row)")) {
            cell.imageContent.image = image
        } else {
            cell.imageContent.setImage(url: tableData[indexPath.row].image) { [weak self] (image) in
                self?.imageCache.setObject(image, forKey: NSString(string: "\(indexPath.row)"))
            }
        }
        
        cell.titleLabel.text = tableData[indexPath.row].title
        cell.descLabel.text = tableData[indexPath.row].desc
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
}

extension UIImageView {
    typealias ImageCompletion = (_ image: UIImage) -> Void
    func setImage(url: String?, completion: @escaping ImageCompletion) {
        image = .checkmark
        guard let url = url else { return }
        Request.fetchImage(url: url).execute(success: { [weak self] (response, data) in
            guard let image = UIImage(data: data) else { return }
            self?.image = image
            completion(image)
        }, failure: { (error) in
            print(error)
            return
        })
    }
}

