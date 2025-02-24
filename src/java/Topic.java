public class Topic {
    private final int topicId;
    private final String title;
    private final String description;

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
