
const ImagesContext = require.context("../../images", true);
const ImgPath = (name) => { return ImagesContext('./'+name); }

export default ImgPath;
