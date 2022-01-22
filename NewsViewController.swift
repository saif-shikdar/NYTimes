//
//  ViewController.swift
//  NYTimes
//
//  Created by Admin on 06/09/2021.
//

import UIKit
import Combine

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let newsViewModel:NewsViewModelType = NewsViewModel()
    var subscriptions:Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBinding()
        newsViewModel.getNews()
    }
    
    private func setupBinding() {
        newsViewModel.newsBinding
            .dropFirst()
            .receive(on: DispatchQueue.main).sink {[weak self ] _  in
                self?.refreshUI()
            }.store(in: &subscriptions)
    }
    
    private func refreshUI() {
    
        tableView.reloadData()
    }

}



extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.numberofItems
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
           return UITableViewCell()
        }
        
        cell.textLabel?.text  = ""
        
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = ""
        
        cell.textLabel?.font  = UIFont.boldSystemFont(ofSize: 16.0)
        
        if let news  = newsViewModel.getNewsDetails(for: indexPath.row) {
            cell.textLabel?.text  = news.title
            cell.detailTextLabel?.text = "\(news.byline) \(news.updatedDate)"
        }
        
      
        
        return cell
    }
    
    
}
