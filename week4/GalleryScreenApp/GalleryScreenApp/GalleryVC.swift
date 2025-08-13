import UIKit

class GalleryVC: UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    var collectionView: UICollectionView!
    var selectedCategory: String?
    var images: [String] = []

    private let spacing: CGFloat = 8
    private var isGrid = true

    // gesture drag and drop tracking
    private var draggedIndexPath: IndexPath?
    private var snapshotView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupToggleButton()
        addLongPressGesture()
    }

    // MARK: - setup methods

    private func setupView() {
        title = selectedCategory ?? "Gallery"
        view.backgroundColor = .white
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")

        view.addSubview(collectionView)
    }

    private func setupToggleButton() {
        let toggle = UIBarButtonItem(title: "Toggle",
                                     style: .plain,
                                     target: self,
                                     action: #selector(toggleLayout))
        navigationItem.rightBarButtonItem = toggle
    }

    private func addLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self,
                                                     action: #selector(handleLongPressGesture(_:)))
        collectionView.addGestureRecognizer(longPress)
    }

    // MARK: - gesture handler for Drag & Drop

    @objc private func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: collectionView)

        switch gesture.state {
        case .began:
            guard let indexPath = collectionView.indexPathForItem(at: location) else { return }
            draggedIndexPath = indexPath

        case .changed:
            guard let draggedIndexPath = draggedIndexPath else { return }

            if let newIndexPath = collectionView.indexPathForItem(at: location),
               newIndexPath != draggedIndexPath
            {
                images.swapAt(draggedIndexPath.item, newIndexPath.item)
                collectionView.moveItem(at: draggedIndexPath, to: newIndexPath)
                self.draggedIndexPath = newIndexPath
            }

        case .ended, .cancelled:
            draggedIndexPath = nil

        default:
            break
        }
    }

    // MARK: - data sources of CollectionView

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell",
                                                      for: indexPath) as! PhotoCell
        cell.configure(with: images[indexPath.item], showTitle: !isGrid)
        return cell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.imageName = images[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }

    // MARK: - CollectionViewDelegateFlowLayout to arrage cells inside our collection view

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt _: Int) -> CGFloat
    {
        return spacing
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt _: Int) -> CGFloat
    {
        return spacing
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        insetForSectionAt _: Int) -> UIEdgeInsets
    {
        UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt _: IndexPath) -> CGSize
    {
        let width = collectionView.bounds.width

        if isGrid {
            let itemsPerRow: CGFloat = 2
            let totalSpacing = spacing * (itemsPerRow + 2)
            let itemWidth = (width - totalSpacing) / itemsPerRow
            return CGSize(width: itemWidth, height: itemWidth)
        } else {
            return CGSize(width: width - (spacing * 2), height: 250)
        }
    }

    // MARK: - collectionView delegate updates layout for toggle functionality

    @objc private func toggleLayout() {
        isGrid.toggle()
        UIView.animate(withDuration: 0.3) {
            self.collectionView.performBatchUpdates(nil)
        }
    }
}
