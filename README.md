# Project Assignment 4
Josefina Valenzuela - Martín Concha

# Summary of implemented futures:

  - Geofence implementation. The address entered by the Super Administrator generates the geofence with an square's shape. Its logitude and latitude are +- 0.1 from the coordenates of the given address. The Administrators that are assigned to a geofence can only manage the Users and Posts that are in the area.
  - Map of Posts and Users.
  - Map with geofence.
  - Recovery password.
  - Report abusive content: any person can send an email to the Crosspatch oficial mail (crosspatch.web@gmail.com; password: crosspatch123).
  - ToS and AuP.
  - Unregistrated users can navigate throw posts and users (only index and show).
  
  - Methods on the Inappropriate Content: 
    * A user that has two or more posts flagged as inaproppriate by three or more different users (and/or administrators) within a week will fall into a blacklist visible by all site administrators.
    * If a user account is blacklisted, the offending posts are hidden and unlinked from the user, and the user account is suspended for one week.
    * If after account suspension the user publishes another post that is flagged inappropriate by three people or more, the user account will be blocked permanently.
    * If a user is send to the blacklist, then his respective posts are send to dumpster.


# Issues
  - Sometimes it's necessary to refresh the page, so the map of the geofence can be shown.
  - The only way to update the geofence is by changing the address of the administrator.
  - The location it's not the real location, but the address that is entered by the user.
  - Once the user is send to the blacklist, and he is supposted to be remove from this one in a week, this action will only take place if the reported user passes throw the home.
  

