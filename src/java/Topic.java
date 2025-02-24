public class Topic {
    private int topicId;
    private String title;
    private String description;

    public Topic(int topicId, String title, String description) {
        this.topicId = topicId;
        this.title = title;
        this.description = description;
    }

    public int getTopicId() {
        return topicId;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }
}
