class RestoreInteractor {
    weak var delegate: IRestoreInteractorDelegate?

    private let authManager: IAuthManager
    private var wordsManager: IWordsManager
    private let appConfigProvider: IAppConfigProvider

    init(authManager: IAuthManager, wordsManager: IWordsManager, appConfigProvider: IAppConfigProvider) {
        self.authManager = authManager
        self.wordsManager = wordsManager
        self.appConfigProvider = appConfigProvider
    }
}

extension RestoreInteractor: IRestoreInteractor {

    var defaultWords: [String] {
        return appConfigProvider.defaultWords
    }

    func validate(words: [String]) {
        do {
            try wordsManager.validate(words: words)
            delegate?.didValidate(words: words)
        } catch {
            delegate?.didFailToValidate(withError: error)
        }
    }

    func restore(withWords words: [String]) {
        do {
            try wordsManager.validate(words: words)
            try authManager.login(withWords: words, newWallet: false)
            wordsManager.isBackedUp = true

            delegate?.didRestore()
        } catch {
            delegate?.didFailToRestore(withError: error)
        }
    }

}

extension RestoreInteractor: IAgreementDelegate {

    func onConfirmAgreement() {
        delegate?.didConfirmAgreement()
    }

}
