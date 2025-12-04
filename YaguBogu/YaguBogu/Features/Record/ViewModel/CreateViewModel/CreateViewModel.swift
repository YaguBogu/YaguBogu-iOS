import RxSwift
import RxRelay
import RxCocoa
import UIKit

final class CreateViewModel{
    private let disposeBag = DisposeBag()
    
    let cancelButtonTapped = PublishRelay<Void>()
    let selectGameButtonTapped = PublishRelay<Void>()
    
    let gameSelected = PublishSubject<SelectGameCellModel>()
    let photoSelected = PublishRelay<UIImage>()
    let titleText = BehaviorRelay<String>(value: "")
    let contentText = BehaviorRelay<String>(value: "")
    
    let confirmButtonTapped = PublishRelay<Void>()
    let dismiss = PublishRelay<Void>()
    let navigateToSelectGame = PublishSubject<Void>()
    let selectedGameText = BehaviorRelay<String>(value: "선택")
    let selectedImage = BehaviorRelay<UIImage?>(value: nil)
    let isConfirmButtonState = BehaviorRelay<Bool>(value: false)
    
    init(){
        bind()
    }
    
    private func bind(){
        
        cancelButtonTapped
            .bind(to: dismiss)
            .disposed(by: disposeBag)
        
        selectGameButtonTapped
            .bind(to: navigateToSelectGame)
            .disposed(by: disposeBag)
        
        gameSelected
            .map{"\($0.myTeamName) vs \($0.opposingTeamName)"}
            .bind(to: selectedGameText)
            .disposed(by: disposeBag)
        
        photoSelected
            .bind(to: selectedImage)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            titleText,
            contentText,
            selectedGameText,
            selectedImage
        )
        .map{title, content, gameText, image in
            let isTitleValid = !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            let isContentValid = !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            let isGameSelectd = gameText != "선택"
            let isImageSelected = image != nil
            
            return isTitleValid && isContentValid && isGameSelectd && isImageSelected
        }
        .bind(to: isConfirmButtonState)
        .disposed(by: disposeBag)
        
        let inputsToSave = Observable.combineLatest(
            self.titleText.asObservable(),
            self.contentText.asObservable(),
            self.gameSelected.asObservable(),
            self.selectedImage.asObservable()
        )
        
        confirmButtonTapped
            .withLatestFrom(inputsToSave)
            .subscribe(onNext: { [weak self] tuple in
                
                guard let self = self else { return }
                
                let (title, content, game, image) = tuple
                
                guard let image = image else { return }
                
                guard let photoData = saveImageCoreData(image: image) else { return }
                
                CoreDataManager.shared.saveRecord(
                    title: title,
                    contentText: content,
                    photoData: photoData,
                    game: game
                )
                .observe(on: MainScheduler.instance)
                .subscribe(onCompleted: {
                    print("CoreData 저장 성공")
                    self.dismiss.accept(())
                }, onError: { error in
                    print("CoreData 저장 실패")
                })
                .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }
    
}
