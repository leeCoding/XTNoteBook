//
//  MainViewController.swift
//  XTNotebook
//
//  Created by Li on 2022/7/28.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,EditNoteViewcontrollerDelegate {
                
    var _tableView : UITableView!

    var _models : [NoteModel] = [NoteModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        RequestManager.postRequest { result in
            switch result {
            case .success(let model):
                print("成功 == \(model)")
            
            case .failure(let error):
                print("失败 == \(error)")
            }
        
        }
        configUI()
    }
    
    func configUI() {
        
        self.title = "笔记"
        
        let addBtn = UIButton.init(type: .contactAdd)
        addBtn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        addBtn.setTitleColor(UIColor.blue, for: .normal)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: addBtn);
        addBtn.addTarget(self, action: #selector(addNote), for: .touchUpInside)
        
        _tableView = UITableView.init(frame: .zero, style: .plain)
        _tableView.delegate = self
        _tableView.dataSource = self
        self.view.addSubview(_tableView)
        
        _tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        _tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        
        print("add content")
            
        createUserTable()
        
        getAllObjects()
    }

    @objc func addNote() {
        
        debugPrint("添加笔记")
        let vc = EditNoteViewController();
        vc.delegate = self;
        self.navigationController?.present(vc, animated: true)
    }
    
    func createUserTable() {
        WCDBManager.manager.createdTable(table: noteModelTableName, of: NoteModel.self)
    }
    
    func getAllObjects() {
        _models.removeAll()
        if let data = WCDBManager.manager.qureyFromDB(tableName: noteModelTableName, cls: NoteModel.self) {
            _models.append(contentsOf: data)
        }
        _tableView.reloadData();
    }

}

// MARK: UITableViewDataSource
extension MainViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell");
        }
        
        let noteModel = _models[indexPath.row]
        cell?.textLabel?.text = noteModel.title;
        
        debugPrint(noteModel.title)
        return cell!
    }
    
}


extension MainViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("\(indexPath.row)")
        let noteModel = _models[indexPath.row]
        let vc = EditNoteViewController()
        vc.noteModel = noteModel
        vc.isEdit = true
        self.present(vc, animated: true)
        
        
    }
}

extension MainViewController {
    
    func callBack(_ content: String) {

        print("callBack == \(content)")
        
        getAllObjects()
    
    }
}
