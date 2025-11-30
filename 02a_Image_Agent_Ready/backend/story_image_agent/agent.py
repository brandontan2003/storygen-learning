# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import json
from typing import AsyncGenerator

from google.adk.agents import BaseAgent
from google.adk.core import Event, InvocationContext
from story_image_agent.imagen_tool import ImagenTool


class CustomImageAgent(BaseAgent):
    """A custom agent that generates images directly using ImagenTool."""

    def __init__(self, name: str = "custom_image_agent"):
        super().__init__(name=name)
        self.imagen_tool = ImagenTool()

    async def _run_async_impl(
        self, ctx: InvocationContext
    ) -> AsyncGenerator[Event, None]:
        """Directly calls the ImagenTool to generate an image."""
        user_message = ctx.user_content.parts[0].text
        try:
            # Attempt to parse the input as JSON
            input_data = json.loads(user_message)
            scene_description = input_data.get("scene_description", "")
            character_descriptions = input_data.get("character_descriptions", {})
        except json.JSONDecodeError:
            # Fallback to using the entire message as the scene description
            scene_description = user_message
            character_descriptions = {}

        # Build the prompt
        prompt_prefix = "Children's book cartoon illustration with bright vibrant colors, simple shapes, friendly characters."
        character_details = ", ".join(
            f"{name}: {desc}" for name, desc in character_descriptions.items()
        )
        
        full_prompt = f"{prompt_prefix} {scene_description}"
        if character_details:
            full_prompt += f". Featuring characters: {character_details}"

        try:
            # Directly call the tool
            image_result = await self.imagen_tool.run(
                prompt=full_prompt,
            )
            
            # Store the successful result in the session state
            ctx.session.state["image_result"] = {
                "status": "success",
                "images": image_result,
            }
            yield Event(
                type="agent.thought",
                data={"thought": f"Successfully generated image(s) for prompt: {full_prompt}"},
            )
            yield Event(
                type="agent.output",
                data={"output": json.dumps(ctx.session.state["image_result"])},
            )

        except Exception as e:
            # Store the error in the session state
            error_message = f"Failed to generate image: {e}"
            ctx.session.state["image_result"] = {
                "status": "error",
                "message": str(e),
            }
            yield Event(
                type="agent.error",
                data={"error": error_message},
            )


# Instantiate the agent
root_agent = CustomImageAgent()
