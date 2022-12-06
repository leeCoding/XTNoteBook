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
     
        /*
        RequestManager.postRequest { result in
            switch result {
            case .success(let model):
                print("成功 == \(model)")
            
            case .failure(let error):
                print("失败 == \(error)")
            }
        
        }
        */
        
        configUI()
    }
    
    func configUI() {
        
        self.title = "笔记"
        
        // add
        let addBtn = UIButton.init(type: .contactAdd)
        addBtn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        addBtn.setTitleColor(UIColor.blue, for: .normal)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: addBtn);
        addBtn.addTarget(self, action: #selector(addNote), for: .touchUpInside)
        
        // 表
        _tableView = UITableView.init(frame: .zero, style: .plain)
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.rowHeight = 70;
        view.addSubview(_tableView)
        
        _tableView.register(UINib.init(nibName: "XTTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
            
        // 文件夹
        let directryBtn = UIButton.init(type: .contactAdd)
        directryBtn.setTitleColor(UIColor.blue, for: .normal)
        self.view.addSubview(directryBtn)
        
        directryBtn.addTarget(self, action: #selector(addDirectry), for: .touchUpInside)
        
        _tableView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view)
            make.bottom.equalTo(directryBtn.snp.top)
        }
        
        directryBtn.snp.makeConstraints { make in
            make.left.equalTo(view.snp_leftMargin).offset(0)
            make.bottom.equalTo(view.snp_bottomMargin)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        createUserTable()
        
        getAllObjects()
    }
    
    @objc func addDirectry() {
        
        debugPrint("添加文件夹")
    }
    
    @objc func addNote() {
        
        let vc = EditNoteViewController();
        vc.delegate = self;
        self.navigationController?.present(vc, animated: true)
    }
    
    func createUserTable() {
        WCDBManager.manager.createdTable(table: noteModelTableName, of: NoteModel.self)
    }
    
    func getAllObjects() {
        _models.removeAll()
        if let data = WCDBManager.manager.qureyFromDB(tableName: noteModelTableName, cls: NoteModel.self,orderBy: [NoteModel.Properties.date.asOrder(by: .descending)]) {
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
        
        let cell: XTTitleTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: "cell") as! XTTitleTableViewCell)
        let noteModel = _models[indexPath.row]
        cell?.loadModel(model: noteModel)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        print("index Path \(IndexPath.self)")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        let noteModel = _models[indexPath.row]
        _models .remove(at: indexPath.row);
        tableView .reloadData()
        
        // 删除数据库
        WCDBManager.manager.deleteFromDB(tableName:noteModelTableName,where: noteModel.identifier)
        
    }
}

extension MainViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("\(indexPath.row)")
        let noteModel = _models[indexPath.row]
        let vc = EditNoteViewController()
        vc.noteModel = noteModel
        vc.isEdit = true
        vc.delegate =  self
        self.present(vc, animated: true)
        
    }
}

extension MainViewController {
    
    func callBack(_ content: String) {
        
        getAllObjects()
    
    }
}
