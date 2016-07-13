//
//  ShowNotesViewController.swift
//  Snap Note
//
//  Created by King Justin on 7/11/16.
//  Copyright © 2016 justinleesf. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    
    var note : Note?
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        
        if let identifier = segue.identifier {
            if identifier == "save" {
                let content = contentTextView.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).characters.count
                let title = titleTextField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).characters.count
                print("The content is \(content!)")
                if let note = note {
                    if ( content! > 0) || (title! > 0) {
                        let newNote = Note()
                        newNote.title = titleTextField.text ?? ""
                        newNote.content = contentTextView.text ?? ""
//                        RealmHelper.updateNote(note, newNote: newNote)
                        listNotesTableViewController.notes.append(newNote)
                    } else {
                        print("delete note")
//                        RealmHelper.deleteNote(note)
                    }
                } else if (contentTextView.text?.characters.count > 0) || (titleTextField.text?.characters.count > 0) {
                    let note = Note()
                    note.title = titleTextField.text ?? ""
                    note.content = contentTextView.text ?? ""
//                    note.modificationTime = NSDate()
//                    RealmHelper.addNote(note)
                }
//                listNotesTableViewController.notes = RealmHelper.retrieveNote()
                
            }
        }
    }
}
