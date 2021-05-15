import UIKit

//Table View
//custom cell
//api caller
//open the news story
//search for news story

class ViewController: UIViewController {

    //table view
    private var tableView:UITableView = {
       let tableView = UITableView()
        tableView.register(NewsTableViewCell.self,
                           forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    
    private var viewmodel = [NewsTableViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubviews()
        
        APICaller.shared.getTopStories{ [weak self] result in
            switch result {
            case .success(let response):
                self?.viewmodel = response.compactMap({
                    NewsTableViewCellViewModel(title: $0.title,
                                               subTitle: $0.articleDescription ?? "No Description",
                                               imageURL: $0.urlToImage ?? ""
                    )
                })
                DispatchQueue.main.async { [self] in
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell) else { fatalError() }
        cell.configure(with: viewmodel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print(" cell selected")
        let vc = DetailedViewController()
        vc.title = "Detailed News"
        vc.modalPresentationStyle = .fullScreen
        vc.model = viewmodel[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
