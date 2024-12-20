## **Requirements and implementation plan for Nam Context screen**

### **1\. Implement Main Menu Infrastructure**

#### **Tasks:**

1. Add a persistent **main menu** available on all screens.  
2. Support a dynamic menu part for navigating to contexts (menu items named after their contexts).  
3. Include static menu items for the inbox and placeholders for future screens.  
4. Ensure seamless navigation between screens.

---

### **2\. Implement Context Screen (Without Reordering)**

#### **Tasks:**

1. Display actions filtered by the context’s rule.  
2. Show action properties (name, description, project name if applicable).  
3. Provide action-specific options:  
   * Open the **edit action** dialog.  
   * Delete the action.  
   * Navigate to the project screen (placeholder for now).  
4. Add a **create action** button:  
   * Create an action tagged with the context’s tags.  
   * Notify the user if retagging removes the action from the context.

---

### **Execution Plan**

#### **Step 1: Set Up Main Menu**

1. **Design the Main Menu**:  
   * Use a `Drawer` widget for the main menu (or consider a `BottomNavigationBar` if preferred).  
   * Separate dynamic and static menu items.  
2. **Add Dynamic Context Navigation**:  
   * Fetch contexts from the repository.  
   * Populate dynamic menu items with context names.  
   * Navigate to the respective context screen on selection.  
3. **Include Static Items**:  
   * Add a menu item for navigating to the inbox screen.  
   * Add placeholders for future screens.  
4. **Integrate Menu with Screens**:  
   * Ensure all screens share the main menu structure.

---

#### **Step 2: Create Context Screen Without Reordering**

1. **Context Filtering**:  
   * Use the context's tags and rule function to filter actions from the repository.  
   * Display the filtered actions in a `ListView`.  
2. **Action Row UI**:  
   * Create a reusable widget for action rows.  
   * Include:  
     * Action name, description, and project name (if applicable).  
     * Buttons for edit, delete, and navigate to project.  
3. **Action Management**:  
   * Implement logic for each action button:  
     * Open the **edit action** dialog.  
     * Delete the action from the repository.  
     * Navigate to the project screen (placeholder).  
4. **Create Action Button**:  
   * Add a FAB to create a new action.  
   * Tag the action with the context's tags.  
   * Open the **edit action** dialog for the new action.  
   * Notify the user if the action leaves the context after retagging.

---

### **Priority Execution Order**

1. **Main Menu Infrastructure**:  
   * Implement the persistent menu across screens.  
   * Verify navigation between inbox and placeholder screens.  
2. **Context Screen**:  
   * Build the context screen without reordering.  
   * Test filtering, editing, deleting, and creating actions.

