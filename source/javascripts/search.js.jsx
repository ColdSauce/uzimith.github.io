
var Search = React.createClass({
  render() {
    return(<input></input>);
  }
});

var ArticleList = React.createClass({
  render() {
    return this.props.data.map( (article) =>
      <Article title={article.title} url={article.url} />
    )
  }
});

var Article = React.createClass({
  render() {
    return(<h1></h1>);
  }
});

React.render(
    <Search />,
    document.getElementById('search'));
var Items = React.createClass({
  itemName(item) {
    return `${item.name}:${item.count}`;
  },
  render() {
    var items = this.props.items.map(item => <span>{this.itemName(item)}</span>);
    return (
      <div>{items}</div>
    );
  }
});
