import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
   
    @objc func saveTask() {
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
        var currentTasks = UserDefaults.standard.stringArray(forKey: "tasks") ?? []
        
        if currentTasks.contains(text) {
            let alert = UIAlertController(title: "Duplicate Task",
                                         message: "This task already exists in your list.",
                                         preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        currentTasks.append(text)
        UserDefaults.standard.setValue(currentTasks, forKey: "tasks")
        
        update?()
        navigationController?.popViewController(animated: true)
    }
    
}
 
