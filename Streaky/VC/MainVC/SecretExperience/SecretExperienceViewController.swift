//
//  SecretExperienceViewController.swift
//  Streaky
//
//  Created by Fatma Buyabes on 04/06/2024.
//

import UIKit

class SecretExperienceViewController: UIViewController {

    var secretExperience : SecretExperience?
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var image = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        print(secretExperience)
//        titleLabel.text = secretExperience?.title
//        descriptionLabel.text  = secretExperience?.title
        setupConstraints()
        setupUI()
        //image.text = secretExperience?.businessImage
        // Do any additional setup after loading the view.
    }
    
    
    func setupConstraints()
    {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.left.right.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
        
//        startButton.snp.makeConstraints { make in
//            make.top.equalTo(questionLabel.snp.bottom).offset(60)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(200)
//            make.height.equalTo(50)
//        }
    }
    
    func setupUI(){
        titleLabel.textColor = .black
        descriptionLabel.textColor = .black

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
