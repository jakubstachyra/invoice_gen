# InvoiceGen
Test user:

    mail: adam@wp.pl
    password: Siema321!

## Overview
### A invoice generator app for  entrepreneurs.
An application allows you to generate invoices and keep them  in one place.
## Project Structure
### Overview
* Project was built using BLOC pattern, Firebase services such as Authentication, Firestore Database and packages for native printing and saving files.
* Almost for each actibity there is specific Bloc which manages events and states. Some of them are created at main.dart such as AuthBloc and some are created on the page level.
* For better usage and readability Firebase is used with specific model and repository for each entity
* All code which contains main logic, for example generating invoices, is written inside BLOC to seperate it from view.
## Folder Structure
* Folder blocs contains authentication/bloc, invoice_generation/bloc, sign_in/bloc, sign_up/cubit.
* Screens folder has files which represent screens of the application, some times they grow too big, so part of them have a nested folder to keep structure as simple as possible.
* Components folder contains some widgets that are being reused in the application or created for specific purposes.
* Packages contains folder for user entity and user repository.
## Data
* User:
  * email: String
  * firstName: String
  * id: String
* Invoice:
    * id(for database purposes): String
    * Seller(Company):
      * name: String
      * addres: String
      * tin: String
    * Customer(Company):
      * name: String
      * addres: String
      * tin: String
    * Details:
      * dateOfPayment: TimeStamp
      * dueDate: TimeStamp
      * id(for client purposes): String
      * place: String
    * Items:
      * List<Item>
        *name: String
        *price: double
        *quantity: int
        *tax: int
* Clients(for user purposes):
  *List<Company>
    * name: String
    * addres: String
    * tin: String
## User Guide
### Sign in/ Sign up
*User can sign in using mail.
*User can sign up, he should provide additionaly his name.
## Home Page
* Home Page displays user's invoices issued
* Clicking floating action button let user issue new invoice
## Invoice generation form
* Contains many pages which user have to follow to issue an invoice
## Invoice menagment form
* Contains delete invoice option
* Contains edit invoice option
* Contains save invoice to pdf option
* Conttains pint invoice option
## Setting Page
* Contains log out button
* Contains option to change invoice view


