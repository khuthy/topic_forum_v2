public class Comment {
    private int commentId;
    private int topicId;
    private int userId;
    private String text;

    // Getter and Setter for commentId
    public int getCommentId() {
        return commentId;
    }
    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    // Getter and Setter for topicId
    public int getTopicId() {
        return topicId;
    }
    public void setTopicId(int topicId) {
        this.topicId = topicId;
    }

    // Getter and Setter for userId
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    // Getter and Setter for text
    public String getText() {
        return text;
    }
    public void setText(String text) {
        this.text = text;
    }
}
