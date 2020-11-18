// User routes
const signup = '​/api​/signup';
const googleSignup = '​/api​/google-signup';
const login = '​/api​/login';
const logout = '​/api​/logout';
const getProfile = '​/api​/profile';
const patchProfile = '​/api​/profile​/';

// Navigation routes
const getCities = '​/api​/';
const getHotelsWithTags= '​/api​/tags​/'; //needs {tag}
const searchHotelsWithName = '​/api​/search';
const fuzzySearch = '​/api​/searchbar'; //Fuzzy search for search bar
const fuzzyTagSearch = '​/api​/search​/tags';
const getHotelById = '​/api​/hotel​/'; // needs {hotelId}
const getHotelRecommendationById = '​/api​/hotel​/{hotelId}​/reccomendations'; //needs {hotelId}

// Booking routes
const getUserBooking = '​/api​/profile​/bookings';
const addNewBooking = '/api/profile/bookings/'; //needs {hotelId}
const deleteBookingById ='​/api​/profile​/bookings​/'; //needs {bookingId}
const editBookingById = '​/api​/profile​/bookings​/'; //needs {bookingId}

// Review routes
const addReviewToHotel = '​/api​/hotel​/{hotelId}​/review'; //needs {hotelId}
