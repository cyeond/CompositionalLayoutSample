//
//  MainViewController.swift
//  CompositionalLayoutSample
//
//  Created by YD on 12/5/23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var dataSource: UICollectionViewDiffableDataSource<Section, SectionItem>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// deviceWidth의 사용으로 viewDidLoad가 아닌 viewDidAppear 내부에 구현하였음
        setCollectionView()
        setDataSource()
        setDataSourceSnapshot()
    }
    
    private func setUI() {
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setCollectionView() {
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        collectionView.setCollectionViewLayout(createCollectionViewLayout(), animated: true)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let deviceWidth = view.window?.windowScene?.screen.bounds.width ?? 200.0
        
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            // item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(deviceWidth))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
        }
    }
    
    private func setDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            var cell = UICollectionViewCell()
            
            switch itemIdentifier {
            case .banner(let itemComponents):
                guard let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else { break }
                bannerCell.configure(title: itemComponents.title, imageUrl: itemComponents.imageUrl)
                cell = bannerCell
            default:
                break
            }
            
            
            return cell
        })
    }
    
    private func setDataSourceSnapshot() {
        let deviceWidth = view.window?.windowScene?.screen.bounds.width ?? 200.0
        var snapshot = NSDiffableDataSourceSnapshot<Section, SectionItem>()
        let banner1Items = [
            SectionItem.banner(SectionItemComponents(title: "First", subtitle: "", imageUrl: "https://source.unsplash.com/user/c_v_r/\(Int(deviceWidth))x\(Int(deviceWidth))")),
            SectionItem.banner(SectionItemComponents(title: "Second", subtitle: "", imageUrl: "https://source.unsplash.com/user/c_v_r/\(Int(deviceWidth))x\(Int(deviceWidth))")),
            SectionItem.banner(SectionItemComponents(title: "Third", subtitle: "", imageUrl: "https://source.unsplash.com/user/c_v_r/\(Int(deviceWidth))x\(Int(deviceWidth))"))
        ]
        
        snapshot.appendSections([Section(id: "Banner1")])
        snapshot.appendItems(banner1Items, toSection: Section(id: "Banner1"))
        
        dataSource?.apply(snapshot)
    }
}
