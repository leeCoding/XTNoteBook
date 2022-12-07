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

    var _models : [DirectryModel] = [DirectryModel]()
    
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
        
        createUserTable()
        
        getAllObjects()
    }
    
    func configUI() {
        
        self.title = "笔记"
        
        // 表
        _tableView = UITableView.init(frame: .zero, style: .plain)
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.rowHeight = 50;
        view.addSubview(_tableView)
        
        _tableView.register(UINib.init(nibName: "DirectryTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
            
        // 文件夹
        let directryBtn = UIButton.init(type: .contactAdd)
        directryBtn.setTitleColor(UIColor.blue, for: .normal)
        directryBtn.addTarget(self, action: #selector(createDirectry), for: .touchUpInside)
        self.view.addSubview(directryBtn)
        
        _tableView.snp.makeConstraints { make in
            make.left.right.top.equalTo(view)
            make.bottom.equalTo(directryBtn.snp.top)
        }
        
        directryBtn.snp.makeConstraints { make in
            make.left.equalTo(view.snp_leftMargin).offset(0)
            make.bottom.equalTo(view.snp_bottomMargin)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
    }
    
    @objc func addNote() {
        
        let vc = EditNoteViewController();
        vc.delegate = self;
        self.navigationController?.present(vc, animated: true)
    }
    
    @objc func createDirectry() {
        
        debugPrint("创建文件夹")
        
        let alert = UIAlertController(title: "文件夹创建", message: "请输入名字", preferredStyle: .alert)
        
        alert.addTextField(){ textField in
                
            
        }
        
        let actionCancel = UIAlertAction(title: "取消", style: .cancel) { action in
            
        }
        
        let actionDone = UIAlertAction(title: "确定", style: .default) { action in
            
            let tf = alert.textFields?.first?.text
            if tf?.isEmpty == false {
                
                let directryModel = self.createDirectryModel(title: tf!)
                WCDBManager.manager.insertDB(object: [directryModel], intotable: directry_model)
                
                debugPrint(tf!)
                
                self.getAllObjects()
            }
            
        }
        
        alert.addAction(actionCancel)
        alert.addAction(actionDone)
        
        self.present(alert, animated: true)
        
    }
    
    func createUserTable() {
        
        WCDBManager.manager.createdTable(table: directry_model, of: DirectryModel.self)
    }
    
    func getAllObjects() {
        
        _models.removeAll()
        
        if let data = WCDBManager.manager.qureyFromDB(tableName: directry_model, cls: DirectryModel.self,orderBy: [DirectryModel.Properties.identifier.asOrder(by: .ascending)]) {
            
            _models.append(contentsOf: data)
        }
        
        if _models.count == 0 {
            
            let directryModel = createDirectryModel(title: "默认")
            WCDBManager.manager.insertDB(object: [directryModel], intotable: directry_model)
        }
        _tableView.reloadData();
    }
    
    func createDirectryModel(title:String) -> DirectryModel {
        
        let directryModel = DirectryModel()
        directryModel.title = title;
        directryModel.date = Date().get_date()
        return directryModel
        
    }

}

// MARK: UITableViewDataSource
extension MainViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DirectryTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: "cell") as! DirectryTableViewCell)
        let model = _models[indexPath.row]
        cell?.loadModel(model: model)
        
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
        let model = _models[indexPath.row]
        _models.remove(at: indexPath.row);
        tableView.reloadData()
        
        // 删除数据库
        WCDBManager.manager.deleteFromDB(tableName:directry_model,where: model.identifier)
        
    }
}

extension MainViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("\(indexPath.row)")
//        let noteModel = _models[indexPath.row]
//        let vc = EditNoteViewController()
//        vc.noteModel = noteModel
//        vc.isEdit = true
//        vc.delegate =  self
//        self.present(vc, animated: true)
        
        let vc = DirectryDetailViewController();
        self.present(vc, animated: true)
    }
}

extension MainViewController {
    
    func callBack(_ content: String) {
        
        getAllObjects()
    
    }
}
