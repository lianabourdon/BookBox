# 📚 BookBox: Community-Driven Book Reviews, Tasks Reading Lists & Lending

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
- 📂 **GitHub**: [[https://github.com/yourusername/bookbox](https://github.com/lianabourdon/BookBox)]([https://github.com/yourusername/bookbox](https://github.com/lianabourdon/BookBox))
- 🌍 **Live App**: [[https://bookbox.herokuapp.com](https://bookbox.herokuapp.com](https://bookbox-app-966dbd8f7ec1.herokuapp.com/))
---

## 🛠️ Setup (For Developers)
```bash
bundle install
yarn install # if using webpacker
rails db:setup
rails s
```

For production:
```bash
heroku config:set CLOUDINARY_URL=cloudinary://<your_key>:<your_secret>@<your_cloud>
```

---

## 👋 License & Credits
Created by Liana, Annabelle, and Cam for COM214 – Final Project. All rights reserved.

