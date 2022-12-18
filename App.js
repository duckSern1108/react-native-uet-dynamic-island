/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React, {useEffect} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  useColorScheme,
  View,
  NativeModules,
  Button,
  Linking,
  Alert,
} from 'react-native';

const {DynamicIslandModule} = NativeModules;
import {Colors, Header} from 'react-native/Libraries/NewAppScreen';

const App = () => {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  const handlerDeepLink = url => {
    const action = url.replace('dynamicisland://', '');
    DynamicIslandModule.endFoodOrderActivity();
    Alert.alert(action);
  };

  useEffect(() => {
    Linking.getInitialURL()
      .then(url => {
        if (url) {
          handlerDeepLink(url);
        }
      })
      .catch(err => {
        console.warn('An error occurred', err);
      });
    Linking.addEventListener('url', ({url}) => {
      if (url) {
        handlerDeepLink(url);
      }
    });
  }, []);

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={backgroundStyle.backgroundColor}
      />
      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        style={backgroundStyle}>
        <Header />
        <View
          style={{
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
          }}>
          <Button
            title="Start Activity"
            onPress={() =>
              
              DynamicIslandModule.startCourseReminderActivity(
                'Uet',
                'Nộp báo cáo môn Dự án công nghệ',
                '23:59 18/12/2022'
              )
            }
          />
          <Button
            title="Update Activity"
            onPress={() =>
              DynamicIslandModule.updateCourseReminderActivity(
                'Còn 1 tiếng để nộp báo cáo môn Dự án công nghệ',
              )
            }
          />
          <Button
            title="End Activity"
            onPress={() => DynamicIslandModule.endCourseReminderActivty()}
          />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

export default App;
