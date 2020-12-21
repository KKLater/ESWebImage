//
//  ViewController.swift
//  ESWebImage
//
//  Created by 罗树新 on 2020/12/20.
//

import UIKit

class ViewController: UIViewController {

    var images = [String]()
    var detail: DetailViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(listView)
        
        images.append("https://img2.rrcimg.com/o_1epvm64qu341853372588451603928817.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64jp27022235518033510339114.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64qu3276622655273893065960736.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64qu5694330335313791277043422.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64c64485625766320445495324479.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64jp6407127454531316083945906.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64qu18895399393788814046327.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64qu594554608939105468418744.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64c62971523595273284906857997.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64c61669810953356363954127857.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64jp277564643253052822963200.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64c6474225693990952328445616.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64jp3004957744490999762816.jpg")
        
        images.append("https://img2.rrcimg.com/o_1epvm64qu3800160425317704429435617.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64jp125525666463598155152.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64c639923142365605354316659.jpg")
        images.append("https://img2.rrcimg.com/o_1epvm64c639923142365605354316659.jpg")
        
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.detail = DetailViewController()
            self.detail?.imageUrlString = self.images.first
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listView.frame = view.bounds
    }

    
    
    lazy var listView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.register(ImageCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(ImageCell.classForCoder()))
        view.estimatedRowHeight = 100
        return view
    }()

}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageUrlStr = images[indexPath.row]
//        let detail = DetailViewController()
//        detail.imageUrlString = imageUrlStr
        if let detail = detail {
            present(detail, animated: true, completion: nil)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ImageCell.classForCoder()), for: indexPath) as!  ImageCell
        cell.contentView.backgroundColor = .white
        let imageUrlStr = images[indexPath.row]
        cell.imgView.loadImage(with: imageUrlStr)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
