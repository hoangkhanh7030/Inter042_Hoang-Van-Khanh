package model;

public class CommenModel extends AbtractModel<CommenModel>{
    private String content;
    private Long userId;
    private Long newId;

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public Long getUserId() {
        return userId;
    }
    public void setUserId(Long userId) {
        this.userId = userId;
    }
    public Long getNewId() {
        return newId;
    }
    public void setNewId(Long newId) {
        this.newId = newId;
    }
}
