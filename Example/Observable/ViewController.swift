import UIKit
import Observable

class ViewController: UIViewController {

    private lazy var collectionView = CollectionView()
    private lazy var slider = Slider(frame: .zero)

    private var collectionDisposable: Disposable?
    private var sliderDisposable: Disposable?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(slider)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),

            slider.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            slider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            slider.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            slider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            slider.heightAnchor.constraint(equalToConstant: 100)
            ])

        collectionDisposable = collectionView.scrollPercentage.addObserver { [weak self] percentage in
            guard let slider = self?.slider else { return }
            slider.value = percentage * slider.maximumValue
        }

        sliderDisposable = slider.position.addObserver { [weak self] position in
            guard let collectionView = self?.collectionView else { return }
            collectionView.contentOffset.x = position * collectionView.contentSize.width - (collectionView.frame.width * position)
        }
    }
}
