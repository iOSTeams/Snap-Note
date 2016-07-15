//
//  ShowNotesViewController.swift
//  Snap Note
//
//  Created by King Justin on 7/11/16.
//  Copyright © 2016 justinleesf. All rights reserved.
//

import UIKit
import RealmSwift
class DisplayNoteViewController: UIViewController {
    
    var note : Note?
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let note = note {
            titleTextField.text = note.title
            contentTextView.text = note.content
        } else {
            titleTextField.text = ""
            contentTextView.text = ""
        }
    }
    
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
        if segue.identifier == "save" {
            
            if let note = note {
                
                let newNote = Note()
                newNote.title = titleTextField.text ?? ""
                newNote.content = contentTextView.text ?? ""
                RealmHelper.updateNote(note, newNote: newNote)
            } else {
                
                let note = Note()
                note.title = titleTextField.text ?? ""
                note.content = contentTextView.text ?? ""
                note.modificationTime = NSDate()
                
                RealmHelper.addNote(note)
            }
            
            listNotesTableViewController.notes = RealmHelper.retrieveNotes()
        }
    }
}
