//
//  HomeViewController.swift
//  CinemaPhile
//
//  Created by astanahub on 22.07.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
   let sectionTitles: [String] = ["Trending Movies","Popular", "Trending TV","Upcoming Movies", "Top rated"]
   
   private let homeFeedTable: UITableView = {
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
       
       let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
       homeFeedTable.tableHeaderView = headerView
   }
    
    private func configureNavbar() {
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let leftBarButtonItem = UIBarButtonItem(customView: imageView)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       homeFeedTable.frame = view.bounds
   }
   
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
      return sectionTitles.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier,
      for: indexPath) as? CollectionViewTableViewCell else {
          return UITableViewCell()
      }

      return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 200
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return 40 // Adjust the height to make space for the title
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      return 10 // Add a small gap at the bottom of each section
  }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x +20 , y: header.bounds.origin.y, width: 100, height: header.bounds.height)
    }
    // add title for each section
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return sectionTitles[section]
  }
   
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
      let defaultOffset = view.safeAreaInsets.top
      let offset = scrollView.contentOffset.y + defaultOffset
      
      navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
  }
}