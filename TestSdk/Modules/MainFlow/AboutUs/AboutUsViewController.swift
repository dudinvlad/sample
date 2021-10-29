//
//  AboutUsViewController.swift
//  TestSdk
//
//  Created Vladislav Dudin on 28.10.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private typealias Module = AboutUsModule
private typealias View = Module.ViewController

extension Module {
    final class ViewController: BaseViewController {
        // MARK: - Dependencies

        var output: ViewOutput!

        private lazy var aboutUsLabel: UILabel = build {
            $0 <~ Style.Label.inputTitleLabel
            $0.numberOfLines = .zero
            $0.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vitae quam quis leo eleifend mollis quis non dolor. Aliquam interdum lorem quis porta efficitur. Nunc efficitur dui vel vulputate maximus. Nunc ornare sodales eros, a efficitur dui. Vivamus eros urna, placerat tempor scelerisque vitae, maximus lobortis libero. Aenean non nibh consequat, pretium libero at, consequat ante. Mauris at nunc eget ante suscipit maximus quis in libero. Nulla facilisi.\n\nFusce id orci a orci pellentesque rhoncus vitae ullamcorper neque. Maecenas pulvinar rhoncus nisi et facilisis. Pellentesque sed felis nisi. Suspendisse at congue turpis, sed molestie lorem. Nunc et venenatis libero, id feugiat augue. Quisque tristique ante sed nunc feugiat, ut eleifend mi fringilla. Integer lectus dui, suscipit vitae vulputate quis, scelerisque lacinia dolor."
        }

        // MARK: - Lifecycle

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        init() {
            super.init(nibName: nil, bundle: nil)

        }

        override func viewDidLoad() {
            super.viewDidLoad()

            output?.didLoad()
            initialSetup()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            output?.didAppear()
        }

        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)

            output?.didDisappear()
        }
    }
}

private extension View {
    func initialSetup() {
        view.addSubview(aboutUsLabel)

        aboutUsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottomMargin.equalToSuperview()
        }
    }
}

extension View: Module.ViewInput { }
