//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Zeynep Özdemir Açıkgöz on 29.11.2022.
//

import UIKit

enum Sections: Int {
    
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case UpComing = 3
    case TopRated = 4
    
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMovie: Title?
    private var headerView: HeroHeaderUIView?
    
    let sectionTitles: [String] = ["Trending Movies", "Trending TV","Popular","UpcomingMovies" ,"Top Rated"]
    
    
    //computer property
    private var homeFeedTable: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        configureHeroHEaderViews()
        
    }
    
    
    private func configureHeroHEaderViews(){
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result{
            case.success(let titles):
                
                let selectedTitle = titles.randomElement()
                
                self?.randomTrendingMovie = selectedTitle
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_name ?? selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))
            case.failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    
    
    
    
    
    private func configureNavbar(){
        
        let navController = navigationController!
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let oiButton = UIButton(type: .system)
        oiButton.setImage(UIImage(named: "netflixLogo")?.withRenderingMode(.alwaysOriginal), for: .normal)
       // oiButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        oiButton.translatesAutoresizingMaskIntoConstraints = false
        
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerWidth = bannerHeight / 2
        
        
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2
        oiButton.widthAnchor.constraint(equalToConstant: bannerWidth).isActive = true
        oiButton.heightAnchor.constraint(equalToConstant: bannerHeight).isActive = true
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: oiButton)
    
        
        
        
        navigationItem.rightBarButtonItems = [
            
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //aralarda bir satır boşluk bırakıyor
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section{
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTVs { result in
                switch result{
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular { result in
                switch result{
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.UpComing.rawValue:
            
            APICaller.shared.getUpComingMovies { result in
                switch result{
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated { result in
                switch result{
                case.success(let titles):
                    cell.configure(with: titles)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView,
              let textLabel = header.textLabel else {return}
        
        textLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        textLabel.frame = CGRect(x: header.bounds.origin.x + 20 , y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        textLabel.textColor = .gray
        textLabel.text = header.textLabel?.text?.capitalizeFirstLetter()
        
    }
    
    //Scrollara header eklendi
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        //ternart operator ? : tek satırda if else benzeri
        return section < sectionTitles.count ? sectionTitles[section] : nil
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}


extension HomeViewController: CollectionViewTableViewCellDelegate{
    
    func collectionViewTableViewCellDidTapCell(_cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
