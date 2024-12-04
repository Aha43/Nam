# **Requirements Document: Next Action Master (Nam)**

## **1\. Introduction**

Next Action Master (Nam) is a personal GTD (Getting Things Done) system designed to help users organize, prioritize, and manage their tasks and projects. Built for flexibility and simplicity, Nam caters to individuals who need an effective system to handle tasks outside of traditional work environments, such as personal projects, errands, and life administration.

### **Purpose**

* Provide a roadmap for implementation, particularly for version 1.0.0.  
* Serve as a foundation for user documentation, presentations, and marketing material.  
* Guide future development by identifying expandable features and architectural considerations.

---

## **2\. Core Concepts**

### **2.1 Inbox Items**

* **Definition:** Unprocessed ideas, tasks, or notes captured for later review.  
* **Purpose:** A "catch-all" for anything the user needs to remember or process.  
* **Key Features:**  
  * Quick entry with minimal effort (e.g., "quick add" button, voice input).  
  * Temporarily stored until processed into actions, projects, or discarded.  
* **Examples:**  
  * "Call the plumber."  
  * "Buy concert tickets."

### **2.2 Actions**

* **Definition:** Individual tasks intended to be completed by the user.  
* **Purpose:** Represent the smallest unit of work in the system.  
* **Key Features:**  
  * Can exist independently or as part of a project.  
  * Can be tagged for prioritization and filtering.  
  * Editable with support for marking as complete.  
* **Examples:**  
  * "Buy nails for the shelf."  
  * "Submit an expense report."

### **2.3 Projects**

* **Definition:** Collections of related actions aimed at achieving a specific goal.  
* **Purpose:** Organize tasks into manageable units of work.  
* **Key Features:**  
  * Can contain actions or subprojects (hierarchical organization).  
  * Descriptions to clarify objectives.  
  * Taggable for categorization and filtering.  
* **Examples:**  
  * "Build a bookshelf" with actions like "Buy wood" and "Assemble shelf."  
  * "Plan family vacation" with subprojects for "Flights" and "Accommodations."

### **2.4 Tags**

* **Definition:** Labels assigned to actions, projects, and contexts for filtering and organization.  
* **Purpose:** Provide flexibility for grouping and retrieving tasks.  
* **Key Features:**  
  * User-customizable.  
  * Support GTD principles (e.g., "next" for prioritization).  
* **Examples:**  
  * "next," "urgent," "shopping."

### **2.5 Contexts**

* **Definition:** Filters that dynamically display subsets of actions and projects based on tags.  
* **Purpose:** Help users focus on tasks relevant to their current situation or environment.  
* **Key Features:**  
  * Dynamically filter tasks based on criteria.  
  * Taggable and appear in other contexts if needed.  
  * Optional read-only modes for predefined views.  
* **Examples:**  
  * "Work," "Next Actions," "Errands."

---

## **3\. User Experience**

### **3.1 Overview of Modes**

Nam organizes functionality into five distinct modes, each serving a unique purpose:

1. **Capture Mode:** Quickly add ideas or tasks to the inbox.  
2. **Processing Mode:** Convert inbox items into actions or projects.  
3. **Reviewing Mode:** Regularly refine and prioritize actions and projects.  
4. **Engaging Mode:** Focused execution of tasks within a context.  
5. **Configuring Mode:** Customize tags, contexts, and system settings.

### **3.2 Key Features by Mode**

#### **Capture Mode**

* Quick entry with minimal UI distractions.  
* Accessible from any screen.

#### **Processing Mode**

* Convert inbox items into tasks or projects.  
* Batch processing for efficiency.

#### **Reviewing Mode**

* Tag or untag actions (e.g., add/remove "next").  
* Refine project details and associated actions.  
* Seamless idea capture during reviews.

#### **Engaging Mode**

* Dynamic task visibility through context filtering.  
* Task creation within contexts inherits relevant tags.  
* Eliminates unnecessary task movement (e.g., "Next Actions" list updates dynamically).

#### **Configuring Mode**

* Create, edit, and delete tags and contexts.  
* Customize system behavior for user preferences.

---

## **4\. Platform and Stack**

### **4.1 Development Framework**

* **Framework:** Flutter.  
* **Language:** Dart.  
* **Rationale:** Cross-platform capabilities, rich widget library, modern async programming model.

### **4.2 Architecture**

* **Layered Architecture:**  
  * **GUI Layer:** User interface and interactions.  
  * **Service Layer:** Business logic (e.g., tagging, context filtering).  
  * **Data Layer:** CRUD operations, JSON serialization, cloud storage interaction.  
* **Future-Proofing:** The data layer is designed to support future transitions to a REST-based backend or database.

### **4.3 Data Storage**

* **Version 1.0.0:** JSON-based storage in cloud file services (e.g., Dropbox, Google Drive).  
* **Advantages:** Simplifies authentication and data management for early versions.

### **4.4 Testing**

* Unit tests for business logic.  
* Widget tests for UI behavior.  
* Integration tests for end-to-end workflows.

### **4.5 Deployment**

* **Version Control:** GitHub.  
* **CI/CD:** GitHub Actions for automated testing and builds.  
* **Initial Platforms:** Mobile (iOS, Android).

---

## **5\. Versioning and Roadmap**

### **5.1 Semantic Versioning**

Nam follows Semantic Versioning (MAJOR.MINOR.PATCH):

* **MAJOR:** Changes with significant leaps in functionality or purpose (e.g., introducing AI features).  
* **MINOR:** Backward-compatible feature additions.  
* **PATCH:** Bug fixes and small improvements.

### **5.2 Roadmap for Version 1.0.0**

* Core features: Inbox, actions, projects, tags, contexts.  
* Two UI views: List View and Field View.  
* JSON-based data storage.  
* Basic cross-platform functionality.

---

## **6\. Future Considerations**

* **AI Features:** Introduce motivational or recreational content inspired by astronaut checklists.  
* **Collaboration:** Expand Nam to support shared projects and tasks.  
* **Advanced Views:** Add specialized UI views like Kanban, Calendar, or Mind Map.  
* **Database Integration:** Transition to a more sophisticated data storage solution.

