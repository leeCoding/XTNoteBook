//
//  EditNoteViewController.swift
//  XTNotebook
//
//  Created by Li on 2022/7/28.
//

import UIKit

protocol EditNoteViewcontrollerDelegate : AnyObject {
    func callBack(_ content:String)
    
}

class EditNoteViewController: BaseViewController, UITextViewDelegate {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var noteModel : NoteModel!
    var isEdit : Bool = false
    
    weak var delegate: EditNoteViewcontrollerDelegate?
    
    lazy var placehold:UILabel = {
        let ph = UILabel();
        ph.text = "开始写点什么"
        ph.textColor = UIColor.lightGray
        return ph;
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createUI()
    }
    
    func createUI() {
        
        view.addSubview(placehold)
        placehold.snp.makeConstraints { make in
            make.left.equalTo(self.contentTextView.snp.left);
            make.top.equalTo(self.contentTextView.snp.top)
            make.width.equalTo(120)
            make.height.equalTo(20);
        }
        
        contentTextView.delegate = self
        
        if  isEdit {
            
            placehold.isHidden = true
            contentTextView.text = noteModel.content
            titleTextField.text = noteModel.title
            
        }else {
            
            placehold.isHidden = false
        }
        
    }

    @IBAction func cancelEventBtn(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func doneEventBtn(_ sender: Any) {
                 
        if isEdit {
            //1.是编辑标题不为空，内容不为空
            //2.如果都为空责询问是否删除
            //3.是否确定
            
            if self.titleTextField.text != "" && self.contentTextView.text != "" {
            
                noteModel.date = currentDateFormatter()
                noteModel.title = self.titleTextField.text!
                noteModel.content = contentTextView.text
                print("id = \(String(describing: noteModel.identifier)),更新内容\(String(describing: noteModel.content))")
                
                //WCDBManager.manager.updateFromDB(tableName: noteModelTableName, on: [NoteModel.Properties.date,NoteModel.Properties.title,NoteModel.Properties.content], with:noteModel, where: noteModel.identifier)
                WCDBManager.manager.insertDB(object: [noteModel], intotable: note_model)
                
            }
            
        }else {
            
            if self.titleTextField.text != "" && self.contentTextView.text != "" {
                
                let noteModel = NoteModel()
                noteModel.date = self.currentDateFormatter()
                noteModel.content = self.contentTextView.text
                noteModel.title = self.titleTextField.text ?? "";
                
                // 插入数据库
                WCDBManager.manager.insertDB(object: [noteModel], intotable: note_model)
                
            }
        }

        delegate?.callBack(self.contentTextView.text)
        
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        }
        */
        self.dismiss(animated: true)
    }
    
    func currentDateFormatter() -> String {
        
        let date = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let string_date = formatter.string(from: date);
        return string_date;
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placehold.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            placehold.isHidden = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


