({
  showNumbers: function (component, event, helper) {
    let numbers = [];
    for (let i = 1; i <= 10; i++) {
      numbers.push(i);
    }
    component.set("v.numbers", numbers);
  }
});
