import UIKit

protocol SomeDelegate: AnyObject {
    func didTapthing()
}
class Foo: SomeDelegate{
    func didTapthing() {
    }
    
    init() {
        let vc = ViewController()
        vc.delegate = self
    }
}
class Person {
    var name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
weak var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")
// Prints "John Appleseed is being initialized"
reference2 = Person(name: "Doyeon Kim")
do {
reference1?.name = reference2!.name
reference2?.name = reference1!.name
}

class ViewController: UIViewController{
    weak var delegate: SomeDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { [weak self] _ in
            self?.doSomething()
        }))
        present(alert, animated: true, completion: nil)
    }
    private func doSomething(){
        
    }
    private var data: Data?
    
    private func getData(string: String, completion: (Data?) -> Void) {
        completion(nil)
    }
    func foo() {
        self.getData(string: "") { [weak self] data in
            guard let strongSelf = self else {
                return
            }
            // self.data = data
            strongSelf.data = data
        }
    }
}
