//
//  ViewController.swift
//  VHLoadingExample
//
//  Created by Vidal_HARA on 8.04.2018.
//  Copyright © 2018 Vidal HARA. All rights reserved.
//

import UIKit
import VHLoading

struct DataItem {
    var type: VHLoading.Animation
    var title: String
    var setting: (() -> Void)?

    func defaultSettings() {
        VHLoading.shared.setAnimation(type, for: .view)
        VHLoading.shared.setAnimation(type, for: .lock)
        VHLoading.shared.setAnimation(type, for: .splash)
    }
}

class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private var dataList: [DataItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(.init(nibName: "AnimationCell", bundle: .main), forCellReuseIdentifier: "Cell")
        self.setDataSource()
    }

    // swiftlint:disable force_cast
    private func setDataSource() {
        dataList.append(DataItem(type: .default, title: "Default", setting: {
            VHLoading.shared.setAnimation(.defaultWith(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), for: .splash)
        }))
        dataList.append(DataItem(type: .dots, title: "Dots", setting: {
            VHLoading.shared.setAnimation(
                .custom({
                    let animator = VHLoading.Animation.dots.animator() as! VHDotsViewController
                    animator.loadViewIfNeeded()
                    animator.color = UIColor.red
                    animator.view.backgroundColor = #colorLiteral(red: 0, green: 0.5694751143, blue: 1, alpha: 1)
                    return animator
                }),
                for: .splash
            )
        }))
        dataList.append(DataItem(type: .dots, title: "Different Dots", setting: {
            VHLoading.shared.setAnimation(
                .custom({
                    let animator = VHLoading.Animation.dots.animator() as! VHDotsViewController
                    animator.loadViewIfNeeded()
                    animator.dotCount = 4
                    return animator
                }),
                for: .lock
            )

            VHLoading.shared.setAnimation(
                .custom({
                    let animator = VHLoading.Animation.dots.animator() as! VHDotsViewController
                    animator.loadViewIfNeeded()
                    animator.color = UIColor.red
                    return animator
                }),
                for: .splash
            )
        }))
        dataList.append(DataItem(type: .custom({ CustomLoadingViewController() }), title: "Custom Loading", setting: {
            VHLoading.shared.setAnimation(
                .custom({
                    let animator = CustomLoadingViewController()
                    animator.view.backgroundColor = #colorLiteral(red: 0.1376178861, green: 0.1214379445, blue: 0.125438273, alpha: 0.495678593)
                    return animator
                }),
                for: .lock
            )

            VHLoading.shared.setAnimation(
                .custom({
                    let animator = CustomLoadingViewController()
                    animator.view.backgroundColor = .black.withAlphaComponent(0.90)
                    return animator
                }),
                for: .splash
            )
        }))
    }
    // swiftlint:enable force_cast
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnimationCell
        cell.configure(with: self.dataList[indexPath.row].title)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dataList[indexPath.row].defaultSettings()
        self.dataList[indexPath.row].setting?()
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self))
        let controller = storyboard.instantiateViewController(withIdentifier: "TryViewControllerID")
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
