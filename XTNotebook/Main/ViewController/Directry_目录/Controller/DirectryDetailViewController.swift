//
//  DirectryDetailViewController.swift
//  XTNotebook
//
//  Created by xc on 2022/12/7.
//

import UIKit

class DirectryDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,EditNoteViewcontrollerDelegate {

    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var _models : [NoteModel] = [NoteModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createUserTable()
        configUI()
        getAllObjects()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configUI() {
        
        tableView.register(UINib.init(nibName: "XTTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rowHeight = 70
        
    }

    @objc func addNote() {
        
        let vc = EditNoteViewController();
        vc.delegate = self;
        self.navigationController?.present(vc, animated: true)
    }
    
    func createUserTable() {
        WCDBManager.manager.createdTable(table: note_model, of: NoteModel.self)
    }
    
    func getAllObjects() {
        _models.removeAll()
        if let data = WCDBManager.manager.qureyFromDB(tableName: note_model, cls: NoteModel.self,orderBy: [NoteModel.Properties.date.asOrder(by: .descending)]) {
            _models.append(contentsOf: data)
        }
        tableView.reloadData();
    }
    
}

extension DirectryDetailViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return _models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: XTTitleTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: "cell") as! XTTitleTableViewCell)
        let noteModel = _models[indexPath.row]
        cell?.loadModel(model: noteModel)
        return cell!
    }
    
}

extension DirectryDetailViewController {
    
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

extension DirectryDetailViewController {
    
    func callBack(_ content: String) {
        
        getAllObjects()
    }
}
