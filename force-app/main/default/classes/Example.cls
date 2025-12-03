public class Example {
    public String name { get; set; }
    public Example() {
        name = '';
    }
    public void show() {
       if (String.isNotBlank(name)) {
            name = 'Hello, ' + name;
        }
    }
}