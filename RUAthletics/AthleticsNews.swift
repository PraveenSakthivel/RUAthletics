//
//  AthleticsNews.swift
//  RUAthletics
//
//  Created by Praveen Sakthivel on 11/15/17.
//  Copyright © 2017 TBLE Technologies. All rights reserved.
//

import UIKit

class AthleticsNews: UITableViewController, XMLParserDelegate {

    //Class Data Variables
    var data = [NewsArticle]()
    var dataItem = NewsArticle()
    var index = Int()
    var thumbnails = [UIImage]()
    //XMLParsing Variables
    var parser = XMLParser()
    var eName = String()
    var eData = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.lightGray
        let navicon = UIButton(type: UIButtonType.system)
        navicon.setImage(defaultMenuImage(), for: UIControlState())
        navicon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menu = UIBarButtonItem(customView: navicon)
        self.navigationItem.leftBarButtonItem = menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        navicon.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        let url:URL = URL(string: "http://scarletknights.com/rss.aspx")!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        thumbnails = Array(repeating: UIImage(), count: data.count)
        loadPictures()
        self.tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    func loadPictures(){
        for i in 0...data.count-1{
        let url = URL(string: data[i].link)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.thumbnails[i] = UIImage(data: data!)!
                self.tableView.reloadData()
            }
        }
    }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName: String?, attributes attributeDict: [String : String])
    {
        eName = elementName
        if elementName == "item" {
            dataItem = NewsArticle()
        }
        else if elementName == "enclosure"{
            if let urlString = attributeDict["url"] {
                dataItem.link = urlString
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if eName == "title" {
                dataItem.title += data
            } else if eName == "link" {
                dataItem.description += data
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            data.append(dataItem)
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imagecell", for: indexPath) as! ImageCell
        cell.title.text = data[indexPath.row].title
        cell.backgroundColor = UIColor.lightGray
        cell.contentView.backgroundColor = UIColor.clear
        cell.thumbnail.image = thumbnails[indexPath.row]
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 80))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        whiteRoundedView.layer.shadowPath = UIBezierPath(rect: whiteRoundedView.bounds).cgPath
        whiteRoundedView.layer.shouldRasterize = true
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = (indexPath as NSIndexPath).row
        self.tableView.deselectRow(at: indexPath, animated:true)
        performSegue(withIdentifier: "showNews", sender:self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let Destination: athNewsWebpage = segue.destination as! athNewsWebpage
        Destination.link = data[index].description
        
    }

}
