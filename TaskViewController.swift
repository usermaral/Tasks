import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    var task: String?
    var taskIndex: Int?
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = task
        
        let editButton = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editTask)
        )
        
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func editTask() {
        let alert = UIAlertController(title: "Edit Task", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = self.task
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let newText = alert.textFields?.first?.text, !newText.isEmpty else { return }
            
            var currentTasks = UserDefaults.standard.stringArray(forKey: "tasks") ?? []
            if let index = self?.taskIndex {
                currentTasks[index] = newText
                UserDefaults.standard.set(currentTasks, forKey: "tasks")
                self?.update?()
                self?.label.text = newText
                self?.task = newText
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
