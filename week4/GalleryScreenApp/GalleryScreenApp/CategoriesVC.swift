import UIKit

class CategoriesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - hard coded data for cells

    private let categories = ["Nature", "Animals", "Cities", "People"]

    private let categoryImages: [String: [String]] = [
        "Nature": ["stock1", "stock2", "stock13"],
        "Animals": ["stock4", "stock5", "stock12", "stock15"],
        "Cities": ["stock3", "stock10", "stock11", "stock14", "stock2", "stock3", "stock10", "stock11", "stock14", "stock2"],
        "People": ["stock5", "stock6", "stock7", "stock8", "stock9", "stock5", "stock6", "stock7", "stock8", "stock9"],
    ]

    private let categoryThumbnails: [String: String] = [
        "Nature": "stock1",
        "Animals": "stock4",
        "Cities": "stock10",
        "People": "stock5",
    ]

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
    }

    // MARK: - setup methods for the table view

    private func setupView() {
        title = "Categories"
        view.backgroundColor = .white
    }

    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(CategoryTableVC.self, forCellReuseIdentifier: "CategoryCell")

        view.addSubview(tableView)
    }

    // MARK: - UITableViewDataSource

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryTableVC
        else { return UITableViewCell() }

        let category = categories[indexPath.row]

        cell.titleLabel.text = category
        let photoCount = categoryImages[category]?.count ?? 0
        cell.countLabel.text = "\(photoCount) photos"

        if let thumbnailName = categoryThumbnails[category] {
            cell.thumbImageView.image = UIImage(named: thumbnailName)
        } else {
            cell.thumbImageView.image = nil
        }

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedCategory = categories[indexPath.row]
        let galleryVC = GalleryVC()
        galleryVC.selectedCategory = selectedCategory
        galleryVC.images = categoryImages[selectedCategory] ?? []

        navigationController?.pushViewController(galleryVC, animated: true)
    }
}
