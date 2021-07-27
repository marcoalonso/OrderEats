//
//  OnboardingViewController.swift
//  OrderEats
//
//  Created by marco rodriguez on 26/07/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Comenzar", for: .normal)
            } else {
                nextButton.setTitle("Siguiente", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        slides = [
            OnboardingSlide(title: "Inicia Sesion", description: "Puedes hacerlo con tu cuenta de Google o con un correo y contraseña que elijas", image: #imageLiteral(resourceName: "slide2")),
            OnboardingSlide(title: "Elige la comida que quieras", description: "Puedes hacerlo con tu cuenta de Google o con un correo y contraseña que elijas", image: #imageLiteral(resourceName: "slide1")),
            OnboardingSlide(title: "Ordena y paga", description: "Puedes hacerlo con tu cuenta de Google o con un correo y contraseña que elijas", image: #imageLiteral(resourceName: "slide3")),
        ]
        
    }
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            //navigate to HomeVC
            let controller = storyboard?.instantiateViewController(identifier: "homeVC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            present(controller, animated: true)
        } else {
            currentPage += 1
            let indexPAth = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPAth, at: .centeredHorizontally, animated: true)
        }
        
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCVC", for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slide: slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
    }
    
    
}
