//
//  ViewController.swift
//  XTNotebook
//
//  Created by Li on 2022/7/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell");
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("\(indexPath.row)")
    }
            
    var _tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configUI()
    }
    
    func configUI() {
        
        _tableView = UITableView.init(frame: .zero, style: .plain)
        _tableView.delegate = self
        _tableView.dataSource = self
        self.view.addSubview(_tableView)
        
        _tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        _tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        
    }


}

