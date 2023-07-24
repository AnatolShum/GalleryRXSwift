//
//  MainController.swift
//  GalleryRXSwift
//
//  Created by Anatolii Shumov on 21/07/2023.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class MainController: UIViewController, UIScrollViewDelegate {
    
    private var collectionView: UICollectionView!
       
    private var viewModel = MainViewModel()
    
    private var bag = DisposeBag()
    
    private var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Gallery"
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.reuseIdentifier)
        view.addSubview(collectionView)
        bindCollectionViewData()
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }

    func bindCollectionViewData() {
        viewModel.items.bind(to: collectionView.rx.items(
            cellIdentifier: MainCell.reuseIdentifier,
            cellType: MainCell.self)) { item, model, cell in
                guard let url = URL(string: model.previewURL) else { return }
                
                cell.pictureView.sd_setImage(with: url, placeholderImage: nil, options: [.continueInBackground, .progressiveLoad])
            }.disposed(by: bag)
        
        collectionView.rx.setDelegate(self).disposed(by: bag)
        viewModel.items.map { $0.count }.subscribe { count in
            self.index = count
        }.disposed(by: bag)
        
        collectionView.rx.willDisplayCell.subscribe { cell, indexPath in
            if self.index - 1 == indexPath.item {
                self.viewModel.page += 1
                self.viewModel.fetchItems()
            }
        }.disposed(by: bag)
        
        collectionView.rx.modelSelected(Model.self).bind { model in
            let detailController = DetailViewController()
            detailController.largeImageURL = model.largeImageURL
            self.navigationController?.pushViewController(detailController, animated: true)
        }.disposed(by: bag)
        
        viewModel.fetchItems()
    }

}

