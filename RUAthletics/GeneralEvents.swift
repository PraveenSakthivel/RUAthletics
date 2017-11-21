//
//  GeneralEvents.swift
//  RUAthletics
//
//  Created by Praveen Sakthivel on 11/17/17.
//  Copyright © 2017 TBLE Technologies. All rights reserved.
//

import UIKit

class GeneralEvents: UITableViewController, XMLParserDelegate {
    
    //Class Data Variables
    var data = [NewsArticle]()
    var dataItem = NewsArticle()
    var tagInfo = String()
    var index = Int()
    var selectedIndex = Int()
    //XMLParsing Variables
    var parser = XMLParser()
    var eName = String()
    var eData = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let navicon = UIButton(type: UIButtonType.system)
        navicon.setImage(defaultMenuImage(), for: UIControlState())
        navicon.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menu = UIBarButtonItem(customView: navicon)
        self.navigationItem.leftBarButtonItem = menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        navicon.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        let url:URL = URL(string: "https://ruevents.rutgers.edu/events/getEventsRss.xml?numberOfDays=7")!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        
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
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName: String?, attributes attributeDict: [String : String])
    {
        eName = elementName
        if elementName == "item" {
            dataItem = NewsArticle()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if eName == "title" {
                dataItem.title += data
            } else if eName == "description" {
                dataItem.description += data
            }
            else if eName == "link"{
                dataItem.link += data
            }
            else{
                tagInfo += data
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            data.append(dataItem)
        }
        else if elementName != "title" && elementName != "description" && elementName != "link"{
            dataItem.tags.append(StringKeyPair(keyParam: elementName,pairParam: tagInfo))
            tagInfo = ""
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "descriptioncell", for: indexPath) as! Description_Cell
        cell.title.text = data[indexPath.row].title
        cell.descbox.text = data[indexPath.row].description
        cell.descbox.textColor = UIColor.gray
        cell.descbox.isScrollEnabled = false
        cell.descbox.isUserInteractionEnabled = false
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = (indexPath as NSIndexPath).row
        self.tableView.deselectRow(at: indexPath, animated:true)
        performSegue(withIdentifier: "GEWeb", sender:self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let Destination: GEWebpage = segue.destination as! GEWebpage
        Destination.link = data[selectedIndex].link
        
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
    
}

