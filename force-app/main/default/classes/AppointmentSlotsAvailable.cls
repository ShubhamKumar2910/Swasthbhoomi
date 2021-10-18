public class AppointmentSlotsAvailable {
    public String name {get;set;}
    public set<String> bookings {get;set;}
    public AppointmentSlotsAvailable(String name,set<String> bookings){
        this.name = name;
        this.bookings = bookings;
    }
}