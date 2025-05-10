# 📚 BookBox: Community-Driven Book Reviews, Reading Lists & Lending

![Ruby on Rails](https://img.shields.io/badge/Rails-7.0-red?logo=rubyonrails)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-blue?logo=postgresql)
![Cloudinary](https://img.shields.io/badge/Images-Cloudinary-lightgrey?logo=cloudinary)
![Bootstrap](https://img.shields.io/badge/Frontend-Bootstrap_5-purple?logo=bootstrap)

---

## 👥 Team Members
- Liana Bourdon  
- Annabelle Duval  
- Cam Nguyen  

---

## 🎯 Project Description
**BookBox** is a full-featured Rails application where users can:
- 📖 Browse & review books
- 🗂️ Organize personal reading lists
- 🔁 Lend books to other users
- 🧠 See tasks, mark progress, and share recommendations

With global admin content, personalized lists, and interactive UI features, BookBox delivers a secure, collaborative reading experience.

---

## 🔐 Authentication & Authorization
- 🔐 **Devise** for user accounts (sign up, login, password resets, account deletion)
- ⚙️ **Admin & Super-Admin roles**
- 🚫 Super-admin is protected from deletion or demotion
- ✅ Secure access controls (`before_action`) for task and book ownership
- 🔁 Forced password reset workflow (e.g., after admin-triggered resets)

---

## 🧩 Models & Relationships (7 Total)
- **User** – Auth with roles & relationships
- **Book** – Title, author, genre, Active Storage cover image
- **Genre** – Global, admin-defined taxonomy
- **Review** – One per user/book, with rating and comment
- **TaskCategory** – Global or personal labels, color-coded
- **ReadingTask** – User’s to-read item with priority, completion, and recommendation
- **Lending** – Tracks active and historical book loans between users

> ✅ All models have strong validations and scoped uniqueness constraints

---

## 🎨 Front-End Design
- 💠 **Bootstrap 5** responsive layout & components
- 🎯 **FontAwesome** icons for all UI interactions
- 🎨 **Custom SCSS** for badges, task colors, and page headers
- 📚 Loaned books grayed out and annotated with borrower info

---

## 💾 Assets & JavaScript
- ☁️ **Cloudinary via Active Storage** for hosted cover uploads
- ⚡ **JavaScript Enhancements Implemented**:
  - 🎛️ **Select2** with cover thumbnails in dropdowns
  - 🔄 **StimulusJS** for dropdown and toggle interactions
  - 🔕 Auto-dismissable flash alerts

---

## 🌐 Core Routes (20+)
- `/` – Public landing page
- `/books` – Filterable library (owned, admin, or borrowed)
- `/books/:id` – Book detail + reviews + tasks
- `/genres` – Browse genres
- `/reading_tasks` – Personal task list
- `/reading_tasks/completed` – Completed tasks view
- `/books/:id/reviews` – Leave/edit/delete reviews
- `/reading_tasks/:id/mark_completed` – Mark task done
- `/reading_tasks/:id/recommend` – Toggle recommended flag
- `/lendings/new` – Initiate lending
- `/lendings/:id/return` – Mark a book as returned
- `/admin/users` – Admin user management (promote, reset pw, delete)

---

## 🚀 Deployment Target
- 🎯 **PostgreSQL** in production
- ☁️ **Cloudinary** for image hosting (manual config via `storage.yml`)
- 🔧 **Heroku-compatible deployment**
- ⚠️ *No `.env` file; credentials entered manually or via platform config vars*

---

## ✅ Additional Features
- 🔁 Lending system with return flow
- 👑 Super-admin shared library
- 🔐 Forced password change post-reset
- 🗂️ Custom & global task categories with colors
- ⭐ Task recommendation toggle
- ⚡ Select2 + Stimulus UI enhancements

---

## 🔗 Repository & Demo
- 📂 **GitHub**: [https://github.com/lianabourdon/bookbox](https://github.com/lianabourdon/BookBox)
- 🌍 **Live App**: [https://bookbox.herokuapp.com](https://bookbox-app-966dbd8f7ec1.herokuapp.com/)
---


---

## 🚀 Deployment
* **PostgreSQL** production DB  
* **Cloudinary** image hosting  
* Deployed on **Heroku** (Config Vars for secrets)  

---

## 🛠️ Local Install & Run (Puma)

### Prerequisites
| Package | Min version | Install note |
|---------|-------------|--------------|
| Ruby | 3.2 | macOS: `brew install ruby@3.2`<br>Ubuntu: rbenv 3.2.x |
| Bundler | latest | `gem install bundler -N` |
| Node.js | 16 | `brew install node` / `apt install nodejs` |
| Git | any | clone repo |
| Build tools | gcc/clang, make, headers | Linux & Windows-native only |

### Quick-start commands

| Platform | Setup (one-time) | Run (every session) |
|----------|------------------|---------------------|
| **macOS (Homebrew)** | ```bash\n/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"\nbrew install ruby@3.2 node\ngem install rails -N``` | ```bash\ngit clone https://github.com/lianabourdon/bookbox.git\ncd bookbox\nbundle install\nbin/rails s``` |
| **Ubuntu 22.04 / Debian** | ```bash\nsudo apt update && sudo apt install -y build-essential libssl-dev libreadline-dev zlib1g-dev curl git\ncurl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-installer | bash\necho 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> ~/.bashrc && source ~/.bashrc\nrbenv install 3.2.2 && rbenv global 3.2.2\ncurl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -\nsudo apt install -y nodejs\ngem install rails -N``` | ```bash\ngit clone https://github.com/lianabourdon/bookbox.git\ncd bookbox\nbundle install\nbin/rails s -b 0.0.0.0``` |
| **Windows (WSL 2)** | `wsl --install` → open Ubuntu → follow Linux column | same as Linux |
| **Windows (RubyInstaller)** | Install **RubyInstaller 3.2 x64** + MSYS2 devkit (“Ridk install” option 3). Install Node LTS. `gem install rails -N`. | ```cmd\ngit clone https://github.com/lianabourdon/bookbox.git\ncd bookbox\nbundle install\nbin\\rails s``` |

When `bin/rails s` runs you’ll see:

Puma starting in single mode...
Listening on http://127.0.0.1:3000



## 🛠️📖 App Functionality
 **Here are every feature present in the codebase** as implemented.

---

### 1 · Authentication & User Accounts

| Feature                              | Details                                                                                                                                                                         |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Devise-based signup / login**      | Users register with **first name, last name, email, password**. A unique `username` is auto-generated on create (`firstInitialLastName_randomNumber`) and stored in the DB.     |
| **Role system**                      | `regular` (default), `admin`, and a protected `super_admin`. Roles drive authorisation checks throughout the controllers.                                                       |
| **First-name display**               | The nav-bar *Account* dropdown greets the current user by first name on every page.                                                                                             |
| **Self-service profile**             | Users can update their profile, change password, or **delete their own account**. Deleting cascades to destroy all Reading Tasks, Reviews, Task Categories, and uploaded media. |
| **Password recovery & forced reset** | Standard Devise reset flow + an admin “Reset Password” action that flags the user to change it on next login.                                                                   |

---

### 2 · Books (Catalogue)

| Feature               | Details                                                                                                                                                                              |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **CRUD**              | Authenticated users can **create, view, edit, and delete** their own Book records.                                                                                                   |
| **Cover uploads**     | Books accept an optional JPEG/PNG cover via **Active Storage + Cloudinary** (auto-thumbnailed).                                                                                      |
| **Genre filter**      | Each Book belongs to one fixed **Genre** (e.g., Fantasy, Biography). Browsing `/books` shows pill buttons to filter by genre; query params keep the filter active across pagination. |
| **Select2 Quick-Add** | When adding a Reading Task, a live **Select2 dropdown** lets users search the catalogue (covers + titles) without leaving the form.                                                  |
| **Pagination**        | Large lists are paginated with Kaminari; query parameters preserved for genre/search filters.                                                                                        |

---

### 3 · Reading Tasks (“To-Dos”)

| Feature            | Details                                                                                                                                                                             |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Create task**    | From any Book card or the “Add Task” page (`/reading_tasks/new`), pick a book, set **priority** (High/Medium/Low) and an optional **Task Category**.                                |
| **Read / update**  | `/reading_tasks` lists current tasks. Inline controls let users change priority, toggle **recommend** flag, move the task to a different Task Category, or open the full edit form. |
| **Mark complete**  | One-click “✓ Done” button calls `PATCH /reading_tasks/:id/mark_completed`, moves the task to `/reading_tasks/completed`, and applies a grey-out badge.                              |
| **Delete task**    | Trash-can icon triggers `DELETE /reading_tasks/:id`.                                                                                                                                |
| **Visual cues**    | Priority levels get color-coded Bootstrap badges; completed tasks appear greyed with a strikethrough title.                                                                         |
| **Completed view** | `/reading_tasks/completed` tab lists finished books with date completed and rating shortcut.                                                                                        |

---

### 4 · Task Categories (user-defined)

| Feature               | Details                                                                                                              |
| --------------------- | -------------------------------------------------------------------------------------------------------------------- |
| **Full CRUD**         | Users create personal categories (`/task_categories/new`), assign them colours, edit names/colours, and delete them. |
| **Scoped uniqueness** | Category name must be unique per-user; deletion is blocked if tasks are still linked (restrict with error).          |
| **Filtering**         | Task index can be filtered by Task Category via dropdown.                                                            |

---

### 5 · Genres (reference data)

| Feature             | Details                                                                                                                                  |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **Fixed seed data** | Ten canonical genres are pre-loaded by `db/seeds.rb` (Fantasy → Young Adult). They are **not editable via UI** to avoid orphaning books. |
| **Index & show**    | `/genres` lists all genres; `/genres/:id` shows a genre banner plus its book catalogue.                                                  |

---

### 6 · Reviews

| Feature                  | Details                                                                                                                                                              |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **One-per-user**         | Users can leave a **star rating (1-5) and a comment** on any book they have read; uniqueness validation prevents multiple reviews by the same user on the same book. |
| **Edit / delete**        | Inline “Edit” and “Delete” icons on the Book detail page; actions routed through nested resources `/books/:book_id/reviews`.                                         |
| **Average rating badge** | Each Book card shows a live average rating badge (filled stars + numeric value).                                                                                     |

---

### 7 · Lending Library

| Feature                 | Details                                                                                                                                               |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Start a loan**        | Owner clicks “Lend” on a Book card, selects a borrower (auto-complete list of registered users). Creates a `Lending` record with `lent_at` timestamp. |
| **Return workflow**     | Borrower (or owner) clicks “Return” to stamp `returned_at`.                                                                                           |
| **Conflict prevention** | Validation blocks new loans if the book is already on loan (only attempts with `returned_at = nil` are checked).                                      |
| **Visual indicators**   | Loaned books show a “📚 Borrowed by <name>” ribbon and are disabled from further edits until returned. The book cover is grayed out.            |

---

### 8 · Admin Console

| Feature                    | Details                                                                                  |
| -------------------------- | ---------------------------------------------------------------------------------------- |
| **User management**        | `/admin/users` grid: promote/demote admins, reset passwords, delete users.               |
| **Super-admin protection** | Callback prevents super-admin account from being altered or destroyed.                   |
| **System metrics**         | Sidebar shows counts of Books, Tasks, Reviews, and Active Loans for quick health checks. |

---

### 9 · Global UX Features

* **Responsive Bootstrap 5.3** layout with dark-mode-friendly palette.
* **Font Awesome 6** icons throughout (actions, ratings, status pills).
* **Turbo + Stimulus** for fast in-place updates (task actions, Select2 searches).
* **Flash messages** with Toast styling for creates/updates/deletes.
* **Accessible keyboard shortcuts** (`?` opens cheatsheet modal).
* **Credits & FAQ pages** explain tech stack and common user questions.

---

### 10 · Data Integrity & Cleanup

* **Cascade deletes** ensure no orphan data (e.g., deleting a user removes their tasks, reviews, categories, and cover uploads).
* **Restrict-with-error** on Task Category deletion prevents losing linked tasks.
* **Database-level foreign-keys** on all `belongs_to` associations.

---


## 👋 License & Credits
Created by Liana, Annabelle, and Cam for COM214 – Final Project. All rights reserved.

