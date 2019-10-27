<template>
    <header>
        <div class="pull-left"><h1><a href="">Bull's Eye</a></h1></div>
        <div class="pull-right">
            <div id="bullseye-problems">
                <div class="flex">
                    <div class="items">
                        <div id="bullseye-problems-mode">play</div>
                    </div>
                    <div class="items" id="bullseye-problems-list"></div>
                    <div class="items" id="bullseye-problems-round"></div>
                    <div class="items">
                        <div id="bullseye-problems-autoplay">&#9654;</div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <div id="bullseye-menu"><a href="<%= url_for :action => 'table' %>">table</a></div>
    <div id="bullseye-teams"></div>
    <div id="bullseye-nowexploiting">
        <div class="message">
            Next deadline<br>
            <input type="time">
        </div>
    </div>

    <div id="bullseye-table">
        <table>
            <!--<tr>
                <th>#</th>
                <th>Team</th>
                {{props problems}}
                <th>{{>prop}}</th>
                {{/props}}
                <th>Jeopardy</th>
                <th>ALL</th>
            </tr>
            {{for teams}}
                <tr>
                <td class="min">{{>#index+1}}</td>
                    <td class="min">{{>name}}</td>
                    {{props ~root.problems ~index=#index}}
                        <td>{{>~root.teams[~index].scores[key]}}</td>
                    {{/props}}
                    <td class="min"><input type="text" class="bullseye-jeopardy" data-team-id="{{>schedule_team_id}}" value="{{>jeopardy}}"></td>
                    <td class="min">{{>score_sum}}</td>
                </tr>
                {{/for}}-->
        </table>
    </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  computed: {
  },
  created () {
  }
}
</script>
