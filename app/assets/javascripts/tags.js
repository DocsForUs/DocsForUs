$(document).ready(() => {
  $(".add-tag").on("click", (event) => {
    event.preventDefault();
    const tagDesc = $("#recommendation_tags_description").val();
    const tagUnderscores = tagDesc.replace(" ", "_")
    let tagHTML = `<li>
        <input class="tag" type="checkbox" value="${tagDesc}" name="recommendation[tags][]" id="recommendation_tags_${tagDesc}" checked>
        <label class="tag-label" for="recommendation_tags_${tagUnderscores}">${tagUnderscores}</label>
      </li>`
    $(".tag-list").append(`${tagHTML}`);
  })
});
