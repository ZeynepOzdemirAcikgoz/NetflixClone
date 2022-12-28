//
//  UpcomingViewController.swift
//  NetflixClone
//
//  Created by Zeynep Özdemir Açıkgöz on 29.11.2022.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    //title atamaları için titleArray oluşturuldu
    private var titles: [Title] = [Title]()
    
    //UpcomingView için tableview tanımlandı
    private let upcomingTable: UITableView = {
        
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        // tabBar ayarlaması yapıldı
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
          fetchUpcoming()
        
    }
    
    //tableView Layout ve frame tanımlamaları
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    
    
    //weak self ??
    private func fetchUpcoming() {
        APICaller.shared.getUpComingMovies { [weak self] result in
            switch result{
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}

//tableview gereksinimleri
extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: title.original_title ?? title.original_name ?? "Unknown Title Name!", posterURL: title.poster_path ?? ""))
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
