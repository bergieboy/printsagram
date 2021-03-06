import { connect } from 'react-redux';
import PhotoFeed from './photo_feed';
import {
  photoSelector,
  userSelector,
  } from '../../selectors/photo_selector';

import {
  fetchPhotos,
  fetchPhoto,
  deletePhoto,
  likePhoto,
  unLikePhoto,
  } from '../../actions/photo_actions';

import {
  createComment,
  deleteComment,
} from '../../actions/comment_actions';

 import {fetchUsers} from '../../actions/user_actions';


const mapStatetoProps = (state) => ({
  photos: photoSelector(state),
  users: userSelector(state),
  comments: Object.values(state.entities.comments),
  currentUser: state.session.currentUser,
});

const mapDispatchToProps = dispatch => ({
  fetchPhotos: () => dispatch(fetchPhotos()),
  deletePhoto: id => dispatch(deletePhoto(id)),
  fetchUsers: () => dispatch(fetchUsers()),
  likePhoto: id => dispatch(likePhoto(id)),
  unLikePhoto: id => dispatch(unLikePhoto(id)),
  createComment: comment => dispatch(createComment(comment)),
  deleteComment: comment => dispatch(deleteComment(comment)),
});

export default connect(mapStatetoProps, mapDispatchToProps)(PhotoFeed);
