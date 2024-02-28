function hideSubjects() {
    let options = document.querySelectorAll(".subjectsOption");
    let node = document.querySelector("#semester");
    options.forEach(option => {
        console.log(node, option)
        if(option.dataset.semester != node.value) {
            option.style.display = "none";
        }else{
            option.style.display = "block";
            option.setAttribute("selected", true);
        }
    })
    if(options.dataset == 0) {
        options[0].setAttribute("selected", true);
    }
}

hideSubjects();