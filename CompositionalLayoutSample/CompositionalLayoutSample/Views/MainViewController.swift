//
//  MainViewController.swift
//  CompositionalLayoutSample
//
//  Created by YD on 12/5/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    let buttonsView = ButtonsView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var dataSource: UICollectionViewDiffableDataSource<Section, SectionItem>?
    private var listLayoutType: ListType = .single
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setButtonAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// deviceWidth의 사용으로 viewDidLoad가 아닌 viewDidAppear 내부에 구현하였음
        setCollectionView()
        setDataSource()
        setDataSourceSnapshot()
    }
    
    private func setUI() {
        self.view.addSubview(buttonsView)
        self.view.addSubview(collectionView)
        self.view.backgroundColor = .black
        
        buttonsView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(buttonsView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        buttonsView.changeToFirstLayoutButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    private func setButtonAction() {
        buttonsView.changeToFirstLayoutButton.addTarget(self, action: #selector(changeLayoutButtonTapped), for: .touchUpInside)
        buttonsView.changeToSecondLayoutButton.addTarget(self, action: #selector(changeLayoutButtonTapped), for: .touchUpInside)
        buttonsView.changeToThirdLayoutButton.addTarget(self, action: #selector(changeLayoutButtonTapped), for: .touchUpInside)
    }
    
    private func setCollectionView() {
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        collectionView.setCollectionViewLayout(createCollectionViewLayout(), animated: true)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layoutConfig = UICollectionViewCompositionalLayoutConfiguration()
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, environment in
            return self?.createListSection()
        }, configuration: layoutConfig)
    }
    
    private func createListSection() -> NSCollectionLayoutSection {
        let deviceWidth = view.window?.windowScene?.screen.bounds.width ?? 200.0
        
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(deviceWidth/CGFloat(listLayoutType.rawValue)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: listLayoutType.rawValue)
        group.contentInsets = .init(top: 10.0, leading: 0, bottom: 0, trailing: 0)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func setDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            var cell = UICollectionViewCell()
            
            switch itemIdentifier {
            case .banner(let itemComponents):
                guard let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else { break }
                bannerCell.configure(title: itemComponents.title, imageUrl: itemComponents.imageUrl)
                cell = bannerCell
            case .list(let itemComponents):
                guard let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else { break }
                listCell.configure(title: itemComponents.title, subtitle: itemComponents.subtitle ?? "", imageUrl: itemComponents.imageUrl)
                cell = listCell
            }
            
            return cell
        })
    }
    
    private func setDataSourceSnapshot() {
        let listItems = DUMMY_ITEMS.map { SectionItem.list($0) }
        var snapshot = NSDiffableDataSourceSnapshot<Section, SectionItem>()

        snapshot.appendSections([Section(id: "List")])
        snapshot.appendItems(listItems, toSection: Section(id: "List"))
        
        dataSource?.apply(snapshot)
    }
    
    @objc func changeLayoutButtonTapped(sender: UIButton) {
        listLayoutType = .init(rawValue: sender.tag) ?? .single
        collectionView.setCollectionViewLayout(createCollectionViewLayout(), animated: false)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredVertically, animated: true)
        
        buttonsView.changeToFirstLayoutButton.setTitleColor(.white, for: .normal)
        buttonsView.changeToSecondLayoutButton.setTitleColor(.white, for: .normal)
        buttonsView.changeToThirdLayoutButton.setTitleColor(.white, for: .normal)
        sender.setTitleColor(.systemBlue, for: .normal)
    }
}

